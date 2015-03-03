<?php
    include("vendor/autoload.php");
    use Facebook\FacebookSession;
    use Facebook\FacebookRequest;
    use Facebook\GraphUser;
    use Facebook\FacebookRequestException;
    use Facebook\FacebookCanvasLoginHelper;
    use Facebook\FacebookRedirectLoginHelper;

    $APP_ID = "1406243513020941";
    $APP_SECRET = "f7287d658dbd36b1394126fb15c374c8";

    FacebookSession::setDefaultApplication($APP_ID, $APP_SECRET);


    //Récupération d'une session si on a pas de token en mémoire

    $helper = new FacebookCanvasLoginHelper();
    try
    {
        $session = $helper->getSession();
    }
    catch(FacebookRequestException $ex)
    {
        print_r($ex);
    }
    catch(\Exception $ex)
    {
        print_r($ex);
    }

    //Passage d'un Short-lived token à un Long-lived token

    if($session)
    {
        $accessToken = $session->getAccessToken();

        try
        {
            $longLivedAccessToken = $accessToken->extend();
        }
        catch(FacebookSDKException $e)
        {
            echo 'Error extending short-lived access token: '.$e->getMessage();
            exit;
        }

        // Enregistrer le token en BDD
    }


    //Appel à l'Open Graph de Facebook

    if($session)
    {
        $request     = new FacebookRequest($session, 'GET', '/me');
        $response    = $request->execute();
        $graphObject = $response->getGraphObject(GraphUser::className());
        // echo '<pre>'.print_r($graphObject,1).'</pre>';
        // echo '<pre>'.print_r($session,1).'</pre>';
    }
    else
    {
        //Si l'utilisateur n'a pas encore autorisé l'application
        $helper = new FacebookRedirectLoginHelper("https://apps.facebook.com/".$APP_ID."/");
        $auth_url = $helper->getLoginUrl(['email']);
        echo 'Redirecting to Facebook authentication page, please wait...<script>top.location.href = "'.$auth_url.'";</script>';
    }
?>