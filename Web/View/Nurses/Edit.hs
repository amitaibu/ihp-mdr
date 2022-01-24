module Web.View.Nurses.Edit where
import Web.View.Prelude

data EditView = EditView
    { nurse :: Nurse
    , authorities :: [ Authority ]

    -- The selected authorities.
    , authorityIds :: [ Id Authority ]
    }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Nurse</h1>
        {renderForm nurse}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Nurses" NursesAction
                , breadcrumbText "Edit Nurse"
                ]

renderForm :: Nurse -> Html
renderForm nurse = formFor nurse [hsx|
    {(textField #name)}
    {(textField #pinCode)}
    {submitButton}

|]