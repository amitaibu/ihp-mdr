module Web.View.Authorities.Show where
import Web.View.Prelude

data ShowView = ShowView { authority :: Authority }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Authority</h1>
        <p>{authority}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Authorities" AuthoritiesAction
                            , breadcrumbText "Show Authority"
                            ]