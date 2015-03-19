package init;

class LoaderDisplay
{
    static public function loaded () {
        var loading = js.Browser.document.getElementById("loading");
        loading.style.display = "none";
        var parent  = loading.parentElement;
        parent.removeChild(loading);
        js.Browser.document.getElementById("game").style.display = "block";
    }

    static var targetValue:Float = 0;


    static public function updateBar (current:Int, max:Int) {
        var value:Float = current / (max - 1);

        var outBar   = js.Browser.document.getElementById("outBar");
        var inBarImg = js.Browser.document.getElementById("inBar");

        targetValue = outBar.offsetWidth * value;
        inBarImg.style.width = outBar.offsetWidth + "px";

        if (!cycleStarted) {
            cycle(0);
            cycleStarted = true;
        }
    }

    private static var cycleStarted = false;
    private static function cycle(pTimeStamp:Float): Void
    {
        var inBar = js.Browser.document.getElementById("inBarContainer");
        if(inBar == null)return;
        var currentWidth = inBar.offsetWidth;
        var diff = targetValue - currentWidth;
        var newValue     = currentWidth + diff / 5;

        inBar.style.width = newValue + "px";

        js.Browser.window.requestAnimationFrame(cast cycle);
    }
}
