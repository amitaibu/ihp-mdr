module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute StaticController
instance AutoRoute DevicesController




-- instance HasPath DevicesController where
--     pathTo DevicesAction = "/Devices"
--     pathTo NewDeviceAction = "/NewDevice"
--     pathTo ShowDeviceAction { deviceId } = "/ShowDevice?deviceId=" ++ tshow deviceId
--     pathTo CreateDeviceAction = "/CreateDevice"
--     pathTo EditDeviceAction { deviceId  } = "/EditDevice?deviceId=" ++ tshow deviceId
--     pathTo UpdateDeviceAction { deviceId } = "/UpdateDevice?deviceId=" ++ tshow deviceId
--     pathTo DeleteDeviceAction { deviceId } = "/DeleteDevice?deviceId=" ++ tshow deviceId
--     pathTo PairDeviceAction { pairingCode } = "/api/pairing-code/" ++ tshow pairingCode

-- instance CanRoute DevicesController where
--    parseRoute' = do
--        let devices = do
--            string "/Devices"
--            optional "/"
--            endOfInput
--            pure DevicesAction

--        let newDevice = do
--            string "/NewDevice"
--            optional "/"
--            endOfInput
--            pure NewDeviceAction

--        let showDevice = do
--            string "/ShowDevice?deviceId="
--            deviceId <- parseId
--            pure ShowDeviceAction { deviceId }

--        let createDevice = do
--            string "/CreateDevice"
--            optional "/"
--            endOfInput
--            pure CreateDeviceAction

--        let editDevice = do
--            string "/EditDevice?deviceId"
--            deviceId <- parseId
--            optional "/"
--            endOfInput
--            pure EditDeviceAction { deviceId }

--        let updateDevice = do
--            string "/UpdateDevice?deviceId="
--            deviceId <- parseId
--            optional "/"
--            endOfInput
--            pure UpdateDeviceAction { deviceId }

--        let deleteDevice = do
--            string "/DeleteDevice?deviceId="
--            deviceId <- parseId
--            optional "/"
--            endOfInput
--            pure DeleteDeviceAction { deviceId }

--        let pairDeviceAction = do
--            string "/api/pairing-code/"
--            pairingCode <- parseText
--            optional "/"
--            endOfInput
--            pure PairDeviceAction { pairingCode }

--        devices
--             <|> newDevice
--             <|> createDevice
--             <|> showDevice
--             <|> editDevice
--             <|> updateDevice
--             <|> deleteDevice
--             <|> pairDeviceAction
instance AutoRoute NursesController


instance AutoRoute AuthoritiesController

