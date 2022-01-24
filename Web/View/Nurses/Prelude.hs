module Web.View.Nurses.Prelude where

import Web.View.Prelude

selectAuthorities :: [ Authority ] -> [ Id Authority ] -> Html
selectAuthorities authorities selectedAuthorityIds = [hsx|
    <div class="flex flex-col my-6 space-y-2">
        <label for="authorities">Authorities</label>
        <select class="form-control" id="authorities" name="authorities" multiple>
            { options }
        </select>
    </div>
|]
    where
        options = map (\authority ->
            let
                selected = get #id authority `elem` selectedAuthorityIds
            in
            [hsx|<option value={show $ get #id authority} selected={selected}>{get #name authority}</option>|]) authorities
                |> mconcat
