module Web.View.Authorities.Edit where
import Web.View.Prelude

data EditView = EditView { authority :: Authority }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Authority</h1>
        {renderForm authority}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Authorities" AuthoritiesAction
                , breadcrumbText "Edit Authority"
                ]

renderForm :: Authority -> Html
renderForm authority = formFor authority [hsx|
    {(textField #name)}
    {submitButton}

|]