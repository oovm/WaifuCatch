$RemoteResources::usage = "";
$LoadedModels::usage = "";
WaifuLoadingModel::usage = "";
Begin["`Private`"];
$LoadedModels = <||>;
$RemoteResources = <|
	"DCGAN-C1" -> <|
		"remote" -> "https://github.com/GalAster/WaifuModelZoo/releases/download/v0.1.0/DCGAN-64.trained.on.Anime.WLNet",
		"local" -> "DCGAN-64 trained on Anime.WLNet"
	|>
|>;

WaifuLoadingModel[name_] := GeneralUtilities`Scope[
	If[
		!MissingQ@$LoadedModels["DCGAN-C1"],
		Return@$LoadedModels["DCGAN-C1"]
	];
	dict = $RemoteResources["DCGAN-C1"];
	object = Check[
		Import[checkDownload@dict, "WLNet"],
		deleteDownload@dict;Return[],
		Import::wlnetcorr
	];
	$LoadedModels["DCGAN-C1"] = object;
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