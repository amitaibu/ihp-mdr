module Web.View.Devices.New where
import Web.View.Prelude

data NewView = NewView
    { device :: Device
    }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Device</h1>
        {renderForm device}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Devices" DevicesAction
                , breadcrumbText "New Device"
                ]

renderForm :: Device -> Html
renderForm device = formFor device [hsx|
    {(textField #name)}
    {(checkboxField #enabled)}

    {(hiddenField #token)}
    {(hiddenField #pairingCode)}
    {(hiddenField #refreshToken)}
    {submitButton}

|]

