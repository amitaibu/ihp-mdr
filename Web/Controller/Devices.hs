module Web.Controller.Devices where

import Web.Controller.Prelude
import Web.View.Devices.Index
import Web.View.Devices.New
import Web.View.Devices.Edit
import Web.View.Devices.Show

instance Controller DevicesController where
    action DevicesAction = do
        (devicesQ, pagination) <- query @Device |> paginate
        devices <- devicesQ |> fetch
        render IndexView { .. }

    action NewDeviceAction = do
        let device = newRecord
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

    action CreatePairDeviceAction { pairingCode} = do
        -- @todo
        redirectTo DevicesAction


buildDevice device = device
    |> fill @["token","pairingCode","refreshToken"]
