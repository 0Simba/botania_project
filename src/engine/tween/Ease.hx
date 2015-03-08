package engine.tween;

/**
 *
 * Created by Jérôme
 */
class Ease {


    // no easing, no acceleration
    public static function linear(t):Float { return t; }
    // accelerating from zero velocity
    public static function easeInQuad(t:Float):Float { return t*t; }
    public static function easeIn(t:Float):Float { return t*t; }
    // decelerating to zero velocity
    public static function easeOutQuad(t:Float):Float { return t*(2-t); }
    public static function easeOut(t:Float):Float { return t*(2-t); }
    // acceleration until halfway, then deceleration
    public static function easeInOutQuad(t:Float):Float { return t<0.5 ? 2*t*t : -1+(4-2*t)*t; }
    public static function easeInOut(t:Float):Float { return t<0.5 ? 2*t*t : -1+(4-2*t)*t; }
    // accelerating from zero velocity
    public static function easeInCubic(t:Float):Float { return t*t*t; }
    // decelerating to zero velocity
    public static function easeOutCubic(t:Float):Float { return (--t)*t*t+1; }
    // acceleration until halfway, then deceleration
    public static function easeInOutCubic(t:Float):Float { return t<0.5 ? 4*t*t*t : (t-1)*(2*t-2)*(2*t-2)+1; }
    // accelerating from zero velocity
    public static function easeInQuart(t:Float):Float { return t*t*t*t; }
    // decelerating to zero velocity
    public static function easeOutQuart(t:Float):Float { return 1-(--t)*t*t*t; }
    // acceleration until halfway, then deceleration
    public static function easeInOutQuart(t:Float):Float { return t<0.5 ? 8*t*t*t*t : 1-8*(--t)*t*t*t; }
    // accelerating from zero velocity
    public static function easeInQuint(t:Float):Float { return t*t*t*t*t; }
    // decelerating to zero velocity
    public static function easeOutQuint(t:Float):Float { return 1+(--t)*t*t*t*t; }
    // acceleration until halfway, then deceleration
    public static function easeInOutQuint(t:Float):Float { return t<0.5 ? 16*t*t*t*t*t : 1+16*(--t)*t*t*t*t; }
    //Bounce Effect:
    public static function bounceOut(t:Float):Float {
        if (t < (1/2.75)) {
            return (7.5625*t*t);
        } else if (t < (2/2.75)) {
            return (7.5625*(t-=(1.5/2.75))*t + 0.75);
        } else if (t < (2.5/2.75)) {
            return (7.5625*(t-=(2.25/2.75))*t + 0.9375);
        } else {
            return (7.5625*(t-=(2.625/2.75))*t + 0.984375);
        }
    }
    public static function bounceIn(t:Float):Float {return 1-bounceOut(1-t);}
    public static function bounceInOut(t:Float):Float {
        if (t < 0.5) return bounceIn(t*2) * 0.5;
        return bounceOut(t*2-1) * 0.5 + 0.5;
    }
    //Back effect
    public static function backIn(t:Float,?s:Float):Float {
        if (s == null) s = 1.70158;
        return t*t*((s+1)*t - s);
    }
    public static function backOut(t:Float,?s:Float):Float {
        if (s == null) s = 1.70158;
        return ((t=t-1)*t*((s+1)*t + s) + 1);
    }
    public static function backOutInvert(t:Float,?s:Float):Float {
        return backOut(1-t);
    }
    public static function backInOut(t:Float,?s:Float):Float {
        if (s == null) s = 1.70158;
        t*=2;
        if (t < 1) return 1/2*(t*t*(((s*=(1.525))+1)*t - s));
        return 1/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2);
    }

}
