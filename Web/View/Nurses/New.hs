module Web.View.Nurses.New where
import Web.View.Prelude

data NewView = NewView
    { nurse :: Nurse
    , authorities :: [ Authority ]
    }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Nurse</h1>
        {renderForm authorities nurse}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Nurses" NursesAction
                , breadcrumbText "New Nurse"
                ]

renderForm :: [ Authority ] -> Nurse -> Html
renderForm authorities nurse = formFor nurse [hsx|
    {(textField #name)}
    {(textField #pinCode)}

    {selectAuthorities authorities}

    {submitButton}

|]



selectAuthorities :: [ Authority ] -> Html
selectAuthorities authorities = [hsx|
    <div class="flex flex-col my-6 space-y-2">
        <label for="authorities">Authorities</label>
        <select class="form-control" id="authorities" name="authorities" multiple>
            { options }
        </select>
    </div>
|]
    where
        options = map (\authority -> [hsx|<option value={show $ get #id authority}>{get #name authority}</option>|]) authorities
                |> mconcat
