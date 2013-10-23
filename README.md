## Font Viewer ##

FontViewer is an iOS font catalogue app. The idea of the app is to display the fonts which are present in the `+(NSArray *)familyNames` method of UIFont. 

In the Settings page, you will be able to apply various settings to the way the fonts are being displayed.

#### Screenshots ####

1. [Settings Screen](https://github.com/devacto/fontviewer-ios/blob/master/screenshots/01_settings_top.png "Settings Screen - Top")

#### Text Alignment Settings ####

Options are LEFT or RIGHT. LEFT option will set the cell label to be aligned to the left. RIGHT option will set the cell label to be aligned to the right.

#### Reverse Character Settings ####

Options are ON or OFF. Setting reverse character to ON will print the character names of the string in reverse. Setting reverse character OFF will print the font names in the usual left-to-right order.

#### Sort By Settings ####

Options are alphabetical order, character count, display size. Alphabetical order sorting is obvious. Sort by character count sorts the table by the number of character that makes up the font name. Sort by display size sorts the table by the width if the name of the font were to be rendered in the specific font at the default size of 14.0f.

#### Sort Type Settings ####

Options are ON or OFF for ascending. Turning it on will sort the table in ascending order based on the sort type (smallest to largest). Turning it off will sort the table in descending order based on the sort type (largest to smallest).

#### Revert Settings ####

Tapping on this will revert the whole app into standard settings of 
* Text alignment: LEFT
* Reverse character: OFF
* Sort by: ALPHABETICAL ORDER
* Sort type: ASCENDING
