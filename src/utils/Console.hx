
package utils;

class Console
{
    public static function group (message:String = null) {
        js.Browser.window.console.group(message);
    }

    public static function log (message:Dynamic) {
        js.Browser.window.console.log(message);
    }

    public static function groupEnd () {
        js.Browser.window.console.groupEnd();
    }
}
