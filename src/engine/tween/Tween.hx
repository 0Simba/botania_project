package engine.tween;

/**
 *
 * Created by Jérôme
 */
import js.Browser;
class Tween {

    /**
     * STATIC PART
     */
    private static var tweens:Array<Tween>;
    private static var deltaTime:Float = 0;
    private static var timeStamp:Float = 0;

    public static function __init__(): Void
    {
        tweens = new Array<Tween>();
        Browser.window.requestAnimationFrame(cast cycle);
    }

    private static function cycle(pTimeStamp:Float): Void
    {
        Browser.window.requestAnimationFrame(cast cycle);

        deltaTime = pTimeStamp - timeStamp;
        timeStamp = pTimeStamp;

        for(i in 0...tweens.length)
        {
            if(tweens[i]._started && !tweens[i]._complete)
                tweens[i].update(deltaTime);
        }
    }

    public static function delete(pTween:Tween): Void
    {
        tweens.splice(tweens.indexOf(pTween), 1);
    }


    /**
     * INSTANCE PART
     */
    private var _started:Bool = false;
    private var _complete:Bool = false;

    private var _duration:Float;
    private var _ease:Dynamic;

    private var _dataFrom:Map<String,Float>;
    private var _dataTo:Map<String,Float>;
    private var _currentDatas:Map<String,Float>;

    private var _onStart:Dynamic;
    private var _onUpdate:Dynamic;
    private var _onComplete:Dynamic;

    private var _currentTime:Float = 0;

    public function new (aDataFrom:Map<String, Float> = null, aDataTo:Map<String, Float> = null, aDuration:Float = 1)
    {
        _ease = Ease.linear;
        _dataFrom     = (aDataFrom != null) ? aDataFrom : new Map<String,Float>();
        _dataTo       = (aDataTo != null)   ? aDataTo : new Map<String,Float>();
        _currentDatas = new Map<String,Float>();
        _duration     = aDuration;

        tweens.push(this);
    }

    public function fromData(pParams:Map<String,Float>): Tween
    {
        for(data in pParams.keys())
            _dataFrom.set(data, pParams.get(data));
        return this;
    }

    public function toData(pParams:Map<String,Float>): Tween
    {
        for(data in pParams.keys())
            _dataTo.set(data, pParams.get(data));
        return this;
    }

    public function duration(pDuration:Float): Tween
    {
        _duration = pDuration;
        return this;
    }

    public function ease(pEase:Dynamic): Tween
    {
        _ease = pEase;
        return this;
    }

    public function onStart(pOnStart:Dynamic): Tween
    {
        _onStart = pOnStart;
        return this;
    }

    public function onUpdate(pOnUpdate:Dynamic): Tween
    {
        _onUpdate = pOnUpdate;
        return this;
    }

    public function onComplete(pOnComplete:Dynamic): Tween
    {
        _onComplete = pOnComplete;
        return this;
    }

    public function start(): Tween
    {
        if(_duration != null) _started = true;
        if(_onStart != null) _onStart(_currentDatas);
        return this;
    }

    private function update(pDeltaTime:Float): Void
    {
        if(_currentTime + pDeltaTime >= _duration)
        {
            _complete = true;
            _currentTime = _duration;
            if(_onComplete != null) _onComplete(_currentDatas);
        }
        else
            _currentTime += pDeltaTime;

        var lCurrentPosition:Float = _currentTime / _duration;
        for(i in _dataFrom.keys())
        {
            var lValue:Float = _ease(lCurrentPosition) * (_dataTo.get(i) - _dataFrom.get(i)) + _dataFrom.get(i);
            _currentDatas.set(i, lValue);
        }
        if(_onUpdate != null) _onUpdate(_currentDatas);
    }
}