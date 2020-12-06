<?php
namespace Class;


require_once ('ProviderController.php');
require_once ('StorageProducts.php');



use Class;
use Class;
/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
class Provider extends ProviderController
{

	private $id;
	private $name;
	public $m_StorageProducts;

	function __construct()
	{
	}

	function __destruct()
	{
	}



	public function GetProviderName()
	{
	}

	/**
	 * 
	 * @param newName
	 */
	public function SetProviderName(String $newName)
	{
	}

}
?>