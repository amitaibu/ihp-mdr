module Web.View.Authorities.Index where
import Web.View.Prelude

data IndexView = IndexView { authorities :: [Authority] , pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewAuthorityAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Authority</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach authorities renderAuthority}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Authorities" AuthoritiesAction
                ]

renderAuthority :: Authority -> Html
renderAuthority authority = [hsx|
    <tr>
        <td>{authority}</td>
        <td><a href={ShowAuthorityAction (get #id authority)}>Show</a></td>
        <td><a href={EditAuthorityAction (get #id authority)} class="text-muted">Edit</a></td>
        <td><a href={DeleteAuthorityAction (get #id authority)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]