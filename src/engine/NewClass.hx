package engine;

	
/**
 * ...
 * @author Baptiser
 */
class NewClass 
{
	
	/**
	 * instance unique de la classe NewClass
	 */
	private static var instance: NewClass;

	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		
	}
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): NewClass {
		if (instance == null) instance = new NewClass();
		return instance;
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	public function destroy (): Void {
		instance = null;
	}

}