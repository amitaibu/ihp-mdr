module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute StaticController
instance AutoRoute DevicesController

instance HasPath DevicesController where
    pathTo DevicesAction = "/Devices"
    pathTo NewDeviceAction = "/NewDevice"
    pathTo ShowDeviceAction { deviceId } = "/ShowDevice/" ++ tshow deviceId
    pathTo CreateDeviceAction = "/CreateDevice"
    pathTo EditDeviceAction { deviceId  } = "/EditDevice/" ++ tshow deviceId
    pathTo UpdateDeviceAction { deviceId } = "/UpdateDevice/" ++ tshow deviceId
    pathTo DeleteDeviceAction { deviceId } = "/DeleteDevice/" ++ tshow deviceId
    pathTo CreatePairDeviceAction { pairingCode } = "/api/pairing-code/" ++ tshow pairingCode

instance CanRoute DevicesController where
   parseRoute' = do
       let devices = do
           string "/Devices"
           optional "/"
           endOfInput
           pure DevicesAction

       let newDevice = do
           string "/NewDevice"
           optional "/"
           endOfInput
           pure NewDeviceAction

       let showDevice = do
           string "/ShowDevice/"
           deviceId <- parseId
           optional "/"
           endOfInput
           pure ShowDeviceAction { deviceId }

       let createDevice = do
           string "/CreateDevice"
           optional "/"
           endOfInput
           pure CreateDeviceAction

       let editDevice = do
           string "/EditDevice/"
           deviceId <- parseId
           optional "/"
           endOfInput
           pure EditDeviceAction { deviceId }

       let updateDevice = do
           string "/UpdateDevice/"
           deviceId <- parseId
           optional "/"
           endOfInput
           pure UpdateDeviceAction { deviceId }

       let deleteDevice = do
           string "/DeleteDevice/"
           deviceId <- parseId
           optional "/"
           endOfInput
           pure DeleteDeviceAction { deviceId }

       let createPairDeviceAction = do
           string "/api/pairing-code/"
           pairingCode <- parseText
           optional "/"
           endOfInput
           pure CreatePairDeviceAction { pairingCode }

       devices
            <|> newDevice
            <|> createDevice
            <|> showDevice
            <|> editDevice
            <|> updateDevice
            <|> deleteDevice
            <|> createPairDeviceAction