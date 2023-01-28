extends Node3D

@export var scene_models_root:Node3D

signal model_loaded(
	model_node:Node,
	skeleton_relative_path:NodePath,
	animation_player:AnimationPlayer)

static func _set_mat_to_unshaded(mat:Material):
	if (mat == null):
		printerr("Mat is null :C")
		return
	if not mat is BaseMaterial3D:
		printerr("I don't know how to set 'unshaded on " + str(mat))
		return
	var spatialmat:BaseMaterial3D = mat
	spatialmat.set_shading_mode(BaseMaterial3D.SHADING_MODE_UNSHADED) 

static func _set_array_mesh_mats_to_unshaded(mesh:ArrayMesh):
	var n_surfaces_count:int = mesh.get_surface_count()
	for i in range(0, n_surfaces_count):
		_set_mat_to_unshaded(mesh.surface_get_material(i))

static func set_all_mats_to_unshaded(node:Node):
	if node is MeshInstance3D:
		if node.mesh is ArrayMesh:
			_set_array_mesh_mats_to_unshaded(node.mesh)

	for child in node.get_children():
		set_all_mats_to_unshaded(child)

func load_glb_model(glb_filepath:String) -> Node:
	var gltf_document:GLTFDocument = GLTFDocument.new()
	var gltf_state:GLTFState = GLTFState.new()
	gltf_state.handle_binary_image = GLTFState.HANDLE_BINARY_EMBED_AS_BASISU
	
	gltf_document.append_from_file(glb_filepath, gltf_state)
	var generated_node:Node = gltf_document.generate_scene(gltf_state)
	if generated_node == null:
		printerr("Something went wrong when trying to load %s" % [glb_filepath])
		return generated_node

	scene_models_root.add_child(generated_node)
	set_all_mats_to_unshaded(generated_node)
	return generated_node

const invalid_node_path:NodePath = NodePath("!INVALID")

func _get_skeleton_path(model:Node, root:Node) -> NodePath:
	var ret:NodePath = invalid_node_path

	if model is Skeleton3D:
		return root.get_path_to(model)

	for child in model.get_children():
		ret = _get_skeleton_path(child, root)
		if ret != invalid_node_path:
			break

	return ret

func get_skeleton_path(model:Node, root:Node) -> NodePath:
	var ret:NodePath = invalid_node_path
	if not root.is_inside_tree():
		printerr("[get_skeleton_path] Add the root to the tree before")
		return ret

	if not model.is_inside_tree():
		printerr("[get_skeleton_path] Add the model to the tree before")
		return ret

	return _get_skeleton_path(model, root)

func try_loading_model_from(filepath:String):

	if filepath.ends_with(".glb"):
		NodeHelpers.remove_children_from(scene_models_root)
		var model_node:Node = load_glb_model(filepath)
		if model_node == null:
			printerr("[_handle_files_drop] Could not the GLB file")
			return
		var skeleton_path:NodePath = get_skeleton_path(model_node, model_node)
		var animation_player:AnimationPlayer = AnimationPlayer.new()
		model_node.add_child(animation_player)
		emit_signal("model_loaded", model_node, skeleton_path, animation_player)
	else:
		printerr("Nope : %s" % [filepath])

func _handle_files_drop(filepaths:PackedStringArray):
	for filepath in filepaths:
		try_loading_model_from(filepath)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("files_dropped", _handle_files_drop)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
