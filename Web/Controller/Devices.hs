module Web.Controller.Devices where

import Web.Controller.Prelude
import Web.View.Devices.Index
import Web.View.Devices.New
import Web.View.Devices.Edit
import Web.View.Devices.Show
import Web.Controller.Prelude (Device'(refreshToken))

instance Controller DevicesController where
    action DevicesAction = do
        (devicesQ, pagination) <- query @Device |> paginate
        devices <- devicesQ |> fetch
        render IndexView { .. }

    action NewDeviceAction = do
        pairingCode <- generateAuthenticationToken
        token <- generateAuthenticationToken
        refreshToken <- generateAuthenticationToken
        let device = newRecord
                |> set #pairingCode (Just pairingCode)
                |> set #token token
                |> set #refreshToken refreshToken

        render NewView { .. }

    action ShowDeviceAction { deviceId } = do
        device <- fetch deviceId
        render ShowView { .. }

    action EditDeviceAction { deviceId } = do
        device <- fetch deviceId
        render EditView { .. }

    action UpdateDeviceAction { deviceId } = do
        device <- fetch deviceId
        device
            |> buildDevice
            |> ifValid \case
                Left device -> render EditView { .. }
                Right device -> do
                    device <- device |> updateRecord
                    setSuccessMessage "Device updated"
                    redirectTo EditDeviceAction { .. }

    action CreateDeviceAction = do
        let device = newRecord @Device
        device
            |> buildDevice
            |> ifValid \case
                Left device -> render NewView { .. }
                Right device -> do
                    device <- device |> createRecord
                    setSuccessMessage "Device created"
                    redirectTo DevicesAction

    action DeleteDeviceAction { deviceId } = do
        device <- fetch deviceId
        deleteRecord device
        setSuccessMessage "Device deleted"
        redirectTo DevicesAction

    action CreatePairDeviceAction { pairingCode } = do
        device <- query @Device
            |> filterWhere (#pairingCode, Just pairingCode)
            |> filterWhere (#enabled, True)
            |> fetchOne

        -- Pairing can only happen once, so we need to remove the pairing code from the Device.
        device <- device
            |> set #pairingCode Nothing
            |> updateRecord

        renderJson (toJSON device)

instance ToJSON Device where
    toJSON device = object
        [ "data" .= object
            [ "id" .= get #id device
            , "device_id" .= get #name device
            , "access_token" .= get #token device
            , "refresh_token" .= get #refreshToken device
            , "created_at" .= get #createdAt device
            ]
        ]


buildDevice device = device
    |> fill @["name", "pairingCode", "token", "refreshToken", "enabled"]
    -- Make sure name is at least 3 digits long.
    |> validateField #name (isGreaterThan 99)
