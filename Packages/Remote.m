(* ::Package:: *)

$RemoteResources::usage = "";
$LoadedModels::usage = "";
WaifuLoadingModel::usage = "";


Begin["`Private`"];


$LoadedModels = <||>;
$RemoteResources = <|
	"E1" -> <|
		"remote" -> "https://github.com/GalAster/WaifuModelZoo/releases/download/v0.1.3/DCGAN-64.trained.on.Anime.WLNet",
		"local" -> "DCGAN-64 trained on Anime.WLNet"
	|>,
	"E2" -> <|
		"remote" -> "https://github.com/GalAster/WaifuModelZoo/releases/download/v0.1.1/DCGAN-64.trained.on.Anime.II.WLNet",
		"local" -> "DCGAN-64 trained on Anime II.WLNet"
	|>,
	"F1" -> <|
		"remote" -> "https://github.com/GalAster/WaifuModelZoo/releases/download/v0.1.2/DCGAN-64.trained.on.Anime.III.WLNet",
		"local" -> "DCGAN-64 trained on Anime III.WLNet"
	|>,
	"F2" -> <|
		"remote" -> "https://github.com/GalAster/WaifuModelZoo/releases/download/v0.1.4/DCGAN-96.trained.on.Anime.WLNet",
		"local" -> "DCGAN-96 trained on Anime.WLNet"
	|>
|>;

WaifuLoadingModel[name_] := GeneralUtilities`Scope[
	If[
		!MissingQ@$LoadedModels[name],
		Return@$LoadedModels[name]
	];
	dict = $RemoteResources[name];
	object = Check[
		Import[checkDownload@dict, "WLNet"],
		deleteDownload@dict;Return[],
		Import::wlnetcorr
	];
	$LoadedModels[name] = object;
	Return@object
];

checkDownload[dict_Association] := GeneralUtilities`Scope[
	file = FileNameJoin[{First@$Data, "Models", "CatchWaifu", dict["local"]}];
	If[
		! FileExistsQ@file,
		URLDownload[dict["remote"], file],
		File[file]
	]
];

deleteDownload[dict_Association] := DeleteFile@FileNameJoin[{First@$Data, "Models", "CatchWaifu", dict["local"]}];


End[]
