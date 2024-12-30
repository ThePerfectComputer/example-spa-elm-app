module Page exposing (Page(..))

import Page.Landing
import Page.Products
import Page.Resources
import Page.About
import Page.Contact

type Page
    = Landing   Page.Landing.Model
    | Products  Page.Products.Model
    | Resources Page.Resources.Model
    | About     Page.About.Model
    | Contact   Page.Contact.Model
