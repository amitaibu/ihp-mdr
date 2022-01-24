module Web.View.Nurses.New where
import Web.View.Prelude
import Web.View.Nurses.Prelude ( selectAuthorities )

data NewView = NewView
    { nurse :: Nurse
    , authorities :: [ Authority ]
    }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Nurse</h1>
        {renderForm authorities nurse}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Nurses" NursesAction
                , breadcrumbText "New Nurse"
                ]

renderForm :: [ Authority ] -> Nurse -> Html
renderForm authorities nurse = formFor nurse [hsx|
    {(textField #name)}
    {(textField #pinCode)}

    {selectAuthorities authorities []}

    {submitButton}

|]