module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
         <ul>
             <li><a href={pathTo DevicesAction}>Devices</a></li>
             <li><a href={pathTo NursesAction}>Nurses</a></li>
         </ul>

|]