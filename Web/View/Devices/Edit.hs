module Web.View.Devices.Edit where
import Web.View.Prelude

data EditView = EditView { device :: Device }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Device</h1>
        {renderForm device}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Devices" DevicesAction
                , breadcrumbText "Edit Device"
                ]

renderForm :: Device -> Html
renderForm device = formFor device [hsx|
    {(textField #name)}
    {submitButton}

|]