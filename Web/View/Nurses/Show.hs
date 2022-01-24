module Web.View.Nurses.Show where
import Web.View.Prelude

data ShowView = ShowView
    { nurse :: Nurse
    , authorities :: [Authority]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Nurse</h1>
        <p>{get #name nurse}</p>
        <div>
            <div>Authorities:</div>
            <ul>
                {authoritiesHtml}
            </ul>
        </div>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Nurses" NursesAction
                            , breadcrumbText "Show Nurse"
                            ]

            authoritiesHtml = forEach authorities $ \authority -> [hsx|
                    <li>{get #name authority}</li>
                |]