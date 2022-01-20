module Web.View.Devices.Show where
import Web.View.Prelude

data ShowView = ShowView { device :: Device }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Device</h1>
        <p>{device}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Devices" DevicesAction
                            , breadcrumbText "Show Device"
                            ]