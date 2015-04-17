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
    private var overlay:Hud;
    private var tween:Tween;

    private function new () {
        leftSeedColo   = new Hud();
        rightSeedColo  = new Hud();
        leftSeedMotif  = new Hud();
        rightSeedMotif = new Hud();

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
        instance.leftSeedColo.set(  size, leftPosition,  "colo"  + codeA.charAt(0) + codeA.charAt(2), "overlay");
        instance.leftSeedMotif.set( size, leftPosition,  "motif" + codeA.charAt(0) + codeA.charAt(1), "overlay");
        instance.rightSeedColo.set( size, rightPosition, "colo"  + codeB.charAt(0) + codeB.charAt(2),  "overlay");
        instance.rightSeedMotif.set(size, rightPosition, "motif" + codeB.charAt(0) + codeB.charAt(1), "overlay");
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
            var newLeftPosition  = new Vector2 (leftPosition.x + (targetPosition.x - leftPosition.x) * ratio, targetPosition.y);
            var newRightPosition = new Vector2 (rightPosition.x + (targetPosition.x - rightPosition.x) * ratio, targetPosition.y);

            leftSeedColo.replace(newLeftPosition);
            leftSeedMotif.replace(newLeftPosition);
            rightSeedColo.replace(newRightPosition);
            rightSeedMotif.replace(newRightPosition);
        });

        tween.onComplete(function () {
            leftSeedColo.sprite.visible   = false;
            leftSeedMotif.sprite.visible  = false;
            rightSeedColo.sprite.visible  = false;
            rightSeedMotif.sprite.visible = false;
        });
    }


    private function createOverlay () {
        overlay = new Hud();
        overlay.set(Vector2.full, Vector2.zero, "white", "overlay");
        overlay.sprite.alpha   = 0.6;
        overlay.sprite.visible = false;
    }
}

