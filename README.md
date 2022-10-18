# sozashop_app

For Networking, initially, http package was used. Later it was changed to dio. A small portion of the app is still in http and needs to be updated. After that, remove http package from the app. Auth token expiration hasn't been handled fully yet.

Bloc used for state management.
For routing, there are two ways. Generated routes used for normal routing and bloc used for routing between the pages of an individual bloc by emitting states.
Generated routes are located at lib\presentation\router\app_router.dart file.
Navigation files used by the bloc are in the respective bloc folders named similar to "blocName_bloc_logic.dart".

login_bloc is used for login, logout, and register.
authentication_bloc is used for the authentication flow.
And internet_bloc is used for checking the internet connectivity.
These 3 are connected. When the internet connectivity is lost user got logged out by tapping the button of the snack bar. Previously it sent the user to a different page instead of logging the user out.

.env files contain the api.
api > individual service > individual repository > individual bloc > output ui

flutter_screenutil package was used for the responsiveness. Check the package details in pub.dev. In a few words, use ".h" with height, ".w" with width, ".r" with radius, and ".sp" with font sizes for responsiveness. Importing the core.dart file will import screen util + custom colors and more often used files. In main.dart the screenutil widget wraps the materialApp widget and there's a property named "designSize". That's the size of my phone, which is redmi 7 pro. The package page has in detailed explanation.

internationalization used the json files located in the assets>i18n folder. arb files located in the lib>l10n folder are not being used.

Every table has separate files for its logic, named similar to "tableName_table_logic.dart". Configure the logic file similar to the other logic files and then pass the file to the component k_table_wrapper. Simply pass the list of the items and the table logic file to the wrapper and the output of the table will the there.
