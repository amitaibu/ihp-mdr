module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data DevicesController
    = DevicesAction
    | NewDeviceAction
    | ShowDeviceAction { deviceId :: !(Id Device) }
    | CreateDeviceAction
    | EditDeviceAction { deviceId :: !(Id Device) }
    | UpdateDeviceAction { deviceId :: !(Id Device) }
    | DeleteDeviceAction { deviceId :: !(Id Device) }
    -- Pairing a device.
    | PairDeviceAction { pairingCode :: !Text }
    deriving (Eq, Show, Data)

data NursesController
    = NursesAction
    | NewNurseAction
    | ShowNurseAction { nurseId :: !(Id Nurse) }
    | CreateNurseAction
    | EditNurseAction { nurseId :: !(Id Nurse) }
    | UpdateNurseAction { nurseId :: !(Id Nurse) }
    | DeleteNurseAction { nurseId :: !(Id Nurse) }
    deriving (Eq, Show, Data)

data AuthoritiesController
    = AuthoritiesAction
    | NewAuthorityAction
    | ShowAuthorityAction { authorityId :: !(Id Authority) }
    | CreateAuthorityAction
    | EditAuthorityAction { authorityId :: !(Id Authority) }
    | UpdateAuthorityAction { authorityId :: !(Id Authority) }
    | DeleteAuthorityAction { authorityId :: !(Id Authority) }
    deriving (Eq, Show, Data)
