package entities;

import engine.isoEngine.components.Hud;
import utils.Vector2;
import engine.tween.Tween;
import engine.tween.Ease;

class MergeAnimation
{
    static public var instance:MergeAnimation;

    private var leftSeedColo:Hud;
    private var leftSeedMotif:Hud;
    private var rightSeedColo:Hud;
    private var rightSeedMotif:Hud;
    private var centerSeedColo:Hud;
    private var centerSeedMotif:Hud;
    private var overlay:Hud;
    private var tween:Tween;

    private function new () {
        leftSeedColo    = new Hud();
        rightSeedColo   = new Hud();
        leftSeedMotif   = new Hud();
        rightSeedMotif  = new Hud();
        centerSeedMotif = new Hud();
        centerSeedColo  = new Hud();

        createOverlay();
        createTween();
    }


    static public function init () {
        instance  = new MergeAnimation();
    }



    static private var size           = new Vector2(0.3, 1, "%", "%x"); // todo export to config
    static private var targetPosition = new Vector2(0.35, 0.35);
    static private var leftPosition   = new Vector2(0.05, 0.35);
    static private var rightPosition  = new Vector2(0.65, 0.35);

    static public function anim (codeA:String, codeB:String, codeMerge:String) {
        instance.applyCodeOn(instance.leftSeedColo,   instance.leftSeedMotif,   codeA,     leftPosition);
        instance.applyCodeOn(instance.rightSeedColo,  instance.rightSeedMotif,  codeB,     rightPosition);
        instance.applyCodeOn(instance.centerSeedColo, instance.centerSeedMotif, codeMerge, targetPosition, false);


        instance.overlay.sprite.visible = true;

        instance.tween.start();
    }


    private function createTween () {
        var from = new Map<String, Float>();
        var to   = new Map<String, Float>();
        from.set("ratio", 0);
        to.set("ratio", 1);


        tween = new Tween (from, to, 2000);
        tween.ease(Ease.bounceOut);

        tween.onUpdate(function (currentDatas) {
            var ratio = currentDatas.get("ratio");
            replaceSeeds(ratio);
            applyAlpha(1 - ratio * 0.8);
        });

        tween.onComplete(function () {
            applyAlpha(1);
            hideSeeds();
            centerSeedColo.sprite.visible  = true;
            centerSeedMotif.sprite.visible = true;

            haxe.Timer.delay(function () {
                centerSeedColo.sprite.visible  = false;
                centerSeedMotif.sprite.visible = false;
                overlay.sprite.visible = false;
            }, 1000);
        });
    }


    private function createOverlay () {
        overlay = new Hud();
        overlay.set(Vector2.full, Vector2.zero, "white", "overlay");
        overlay.sprite.alpha   = 0.6;
        overlay.sprite.visible = false;
    }


    private function replaceSeeds (ratio:Float) {
        var newLeftPosition  = new Vector2 (leftPosition.x + (targetPosition.x - leftPosition.x) * ratio, targetPosition.y);
        var newRightPosition = new Vector2 (rightPosition.x + (targetPosition.x - rightPosition.x) * ratio, targetPosition.y);

        leftSeedColo.replace(newLeftPosition);
        leftSeedMotif.replace(newLeftPosition);
        rightSeedColo.replace(newRightPosition);
        rightSeedMotif.replace(newRightPosition);
    }


    private function applyAlpha (ratio:Float) {
        leftSeedColo.sprite.alpha   = ratio;
        leftSeedMotif.sprite.alpha  = ratio;
        rightSeedColo.sprite.alpha  = ratio;
        rightSeedMotif.sprite.alpha = ratio;
    }

    private function hideSeeds () {
        leftSeedColo.sprite.visible   = false;
        leftSeedMotif.sprite.visible  = false;
        rightSeedColo.sprite.visible  = false;
        rightSeedMotif.sprite.visible = false;
    }


    private function applyCodeOn (colo:Hud, motif:Hud, code:String, position:Vector2, show:Bool = true) {
        colo.set( size, position,  "colo"  + code.charAt(0) + code.charAt(2), "overlay");
        motif.set(size, position,  "motif" + code.charAt(0) + code.charAt(1), "overlay");
        motif.sprite.visible = show;
        colo.sprite.visible  = show;
    }
}

