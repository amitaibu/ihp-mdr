module Web.View.Nurses.Index where
import Web.View.Prelude

data IndexView = IndexView { nurses :: [Nurse] , pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewNurseAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Nurse</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach nurses renderNurse}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Nurses" NursesAction
                ]

renderNurse :: Nurse -> Html
renderNurse nurse = [hsx|
    <tr>
        <td>{nurse}</td>
        <td><a href={ShowNurseAction (get #id nurse)}>Show</a></td>
        <td><a href={EditNurseAction (get #id nurse)} class="text-muted">Edit</a></td>
        <td><a href={DeleteNurseAction (get #id nurse)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]