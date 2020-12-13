<?php
namespace Class;




/**
 * @author Nikola-Ver
 * @version 1.0
 * @created 03-���.-2020 23:36:09
 */
interface IDataBase
{

	/**
	 * 
	 * @param entity
	 */
	public function AddEntity(Object $entity);

	/**
	 * 
	 * @param entity
	 */
	public function DeleteEntity(Object $entity);

	/**
	 * 
	 * @param entity
	 */
	public function EditEntity(Object $entity);

	/**
	 * 
	 * @param param
	 */
	public function GetAllList(String $param);

	/**
	 * 
	 * @param param
	 */
	public function GetEntity(String $param);

	/**
	 * 
	 * @param param
	 */
	public function GetList(String $param);

	/**
	 * 
	 * @param param
	 */
	public function GetListByCriteria(String $param);

}
?>