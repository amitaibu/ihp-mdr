module Web.View.Nurses.Edit where
import Web.View.Prelude
import Web.View.Nurses.Prelude ( selectAuthorities )

data EditView = EditView
    { nurse :: Nurse
    , authorities :: [ Authority ]

    -- The selected authorities.
    , selectedAuthorityIds :: [ Id Authority ]
    }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Nurse</h1>
        {renderForm nurse authorities selectedAuthorityIds}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Nurses" NursesAction
                , breadcrumbText "Edit Nurse"
                ]

renderForm :: Nurse -> [ Authority ] -> [ Id Authority ] -> Html
renderForm nurse authorities selectedAuthorityIds = formFor nurse [hsx|
    {(textField #name)}
    {(textField #pinCode)}

    {selectAuthorities authorities selectedAuthorityIds}

    {submitButton}

|]