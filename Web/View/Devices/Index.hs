module Web.View.Devices.Index where
import Web.View.Prelude
import Data.Maybe

data IndexView = IndexView { devices :: [ Device ] , pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewDeviceAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Device</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach devices renderDevice}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Devices" DevicesAction
                ]

renderDevice :: Device -> Html
renderDevice device = [hsx|
    <tr>
        <td>{get #name device} | {pairingCode}</td>
        <td><a href={ShowDeviceAction (get #id device)}>Show</a></td>
        <td><a href={EditDeviceAction (get #id device)} class="text-muted">Edit</a></td>
        <td><a href={DeleteDeviceAction (get #id device)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
    where
        pairingCode =
            fromMaybe "--Already paired--" (get #pairingCode device)