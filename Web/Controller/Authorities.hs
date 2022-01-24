module Web.Controller.Authorities where

import Web.Controller.Prelude
import Web.View.Authorities.Index
import Web.View.Authorities.New
import Web.View.Authorities.Edit
import Web.View.Authorities.Show

instance Controller AuthoritiesController where
    action AuthoritiesAction = do
        (authoritiesQ, pagination) <- query @Authority |> paginate
        authorities <- authoritiesQ |> fetch
        render IndexView { .. }

    action NewAuthorityAction = do
        let authority = newRecord
        render NewView { .. }

    action ShowAuthorityAction { authorityId } = do
        authority <- fetch authorityId
        render ShowView { .. }

    action EditAuthorityAction { authorityId } = do
        authority <- fetch authorityId
        render EditView { .. }

    action UpdateAuthorityAction { authorityId } = do
        authority <- fetch authorityId
        authority
            |> buildAuthority
            |> ifValid \case
                Left authority -> render EditView { .. }
                Right authority -> do
                    authority <- authority |> updateRecord
                    setSuccessMessage "Authority updated"
                    redirectTo EditAuthorityAction { .. }

    action CreateAuthorityAction = do
        let authority = newRecord @Authority
        authority
            |> buildAuthority
            |> ifValid \case
                Left authority -> render NewView { .. } 
                Right authority -> do
                    authority <- authority |> createRecord
                    setSuccessMessage "Authority created"
                    redirectTo AuthoritiesAction

    action DeleteAuthorityAction { authorityId } = do
        authority <- fetch authorityId
        deleteRecord authority
        setSuccessMessage "Authority deleted"
        redirectTo AuthoritiesAction

buildAuthority authority = authority
    |> fill @'["name"]
