module Web.View.Authorities.New where
import Web.View.Prelude

data NewView = NewView { authority :: Authority }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Authority</h1>
        {renderForm authority}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Authorities" AuthoritiesAction
                , breadcrumbText "New Authority"
                ]

renderForm :: Authority -> Html
renderForm authority = formFor authority [hsx|
    {(textField #name)}
    {submitButton}

|]