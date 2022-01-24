module Web.Controller.Nurses where

import Web.Controller.Prelude
import Web.View.Nurses.Index
import Web.View.Nurses.New
import Web.View.Nurses.Edit
import Web.View.Nurses.Show
import Data.Text ( toLower, take )
import Web.Controller.Prelude (Nurse'(pinCode))

instance Controller NursesController where
    action NursesAction = do
        (nursesQ, pagination) <- query @Nurse |> paginate
        nurses <- nursesQ |> fetch
        render IndexView { .. }

    action NewNurseAction = do
        authorities <- query @Authority |> fetch

        pinCode <- generateAuthenticationToken
        let pinCodeShort = pinCode
                |> Data.Text.take 4
                |> Data.Text.toLower

        let nurse = newRecord
                |> set #pinCode pinCodeShort

        render NewView { .. }

    action ShowNurseAction { nurseId } = do
        nurse <- fetch nurseId

        nurseAuthorityRefs <- query @NurseAuthorityRef
            |> filterWhere (#nurseId, get #id nurse)
            |> fetch

        let authorityIds = map (get #authorityId) nurseAuthorityRefs

        authorities <- query @Authority |> filterWhereIn (#id, authorityIds) |> fetch

        render ShowView { .. }

    action EditNurseAction { nurseId } = do
        authorities <- query @Authority |> fetch

        nurseAuthorityRefs <- query @NurseAuthorityRef
            |> filterWhere (#nurseId, nurseId)
            |> fetch

        let selectedAuthorityIds = map (get #authorityId) nurseAuthorityRefs

        nurse <- fetch nurseId
        render EditView { .. }

    action UpdateNurseAction { nurseId } = do
        nurseAuthorityRefs <- query @NurseAuthorityRef
            |> filterWhere (#nurseId, nurseId)
            |> fetch

        let selectedAuthorityIds = map (get #authorityId) nurseAuthorityRefs

        nurse <- fetch nurseId
        nurse
            |> buildNurse
            |> ifValid \case
                Left nurse -> do
                    authorities <- query @Authority |> fetch
                    render EditView { .. }
                Right nurse -> do
                    nurse <- nurse |> updateRecord

                    -- Update the multiple refs. We first delete existing ones, and
                    -- then we'll recreate.
                    deleteRecords nurseAuthorityRefs

                    let authorities = paramList @UUID "authorities"
                    forEach authorities $ \authorityId -> do
                        let nurseAuthorityRef = newRecord @NurseAuthorityRef
                                |> set #nurseId (get #id nurse)
                                |> set #authorityId (Id authorityId)
                        nurseAuthorityRef |> createRecord
                        pure ()

                    setSuccessMessage "Nurse updated"
                    redirectTo EditNurseAction { .. }

    action CreateNurseAction = do
        let nurse = newRecord @Nurse
        nurse
            |> buildNurse
            |> ifValid \case
                Left nurse -> do
                    authorities <- query @Authority |> fetch
                    render NewView { .. }

                Right nurse -> do
                    nurse <- nurse |> createRecord

                    -- Create the multiple refs.
                    let authorities = paramList @UUID "authorities"
                    forEach authorities $ \authorityId -> do
                        let nurseAuthorityRef = newRecord @NurseAuthorityRef
                                |> set #nurseId (get #id nurse)
                                |> set #authorityId (Id authorityId)
                        nurseAuthorityRef |> createRecord
                        pure ()

                    setSuccessMessage "Nurse created"
                    redirectTo NursesAction

    action DeleteNurseAction { nurseId } = do
        nurse <- fetch nurseId
        deleteRecord nurse
        setSuccessMessage "Nurse deleted"
        redirectTo NursesAction

buildNurse nurse = nurse
    |> fill @["name","pinCode"]
    |> validateField #name nonEmpty
    |> validateField #pinCode nonEmpty
