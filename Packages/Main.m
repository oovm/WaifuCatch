$Root::usage = "";
$Data::usage = "";
$RootNN::usage = "";
Begin["`Private`"];
$Root = File@DirectoryName[FindFile["CatchWaifu`"], 2];
$Data = File@If[
	MissingQ@PersistentValue["CatchWaifu", "Local"],
	(*PersistentValue["DeepMath", "Local"] ="D:\\NeuralNetworks"*)
	PersistentValue["CatchWaifu", "Local"] = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "NeuralNetworks"}];
	PersistentValue["CatchWaifu", "Local"],
	PersistentValue["CatchWaifu", "Local"]
];
$RootNN = File@DirectoryName[FindFile["NeuralNetworks`"], 2];
If[
	! FileExistsQ@ FileNameJoin[{First@$Data, "Models", "CatchWaifu"}],
	CreateDirectory@FileNameJoin[{First@$Data, "Models", "CatchWaifu"}]
];


(*Extension*)
PackageExtendContextPath[{
	"GeneralUtilities`"
}];

addLayer[name_] := Block[
	{file },
	file = NeuralNetworks`Private`ReadDefinitionFile[
		FileNameJoin[{First@$Root, "Resources", "Layers", name <> ".m"}],
		"NeuralNetworks`"
	];
	NeuralNetworks`DefineLayer[name, file]
];

NeuralNetworks`PixelShuffleLayer;
addLaye@"PixelShuffle";
NeuralNetworks`LeakyReLU;
addLayer@"LeakyReLU";
NeuralNetworks`PixelNormalizationLayer;
addLayer@"PixelNorm";

End[]