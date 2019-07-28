(* ::Package:: *)

(* ::Section:: *)
(*Declare*)


BeginPackage["CatchWaifu`"];
WaifuLab::usage = "";
WaifuLabGrid::usage = "";
Begin["`Private`"];


(* ::Section:: *)
(*WaifuLabs*)


(* ::Item:: *)
(*Model: StyleGAN*)


(* ::Item:: *)
(*WaifuLabs: https://waifulabs.com/*)


WaifuLab[index_Integer] := WaifuLab[index, index, index];
WaifuLab[new_Integer, pose_Integer, color_Integer] := Module[
	{settings, request, girl},
	settings = <|
		"currentGirl" -> { pose, 0, 0, 0, new, 0, 0, 0, 0, 0, 0, 0, color, 0, 0, 0, 0, {0, 0, 0}},
		"step" -> 4,
		"size" -> 512
	|>;
	request = HTTPRequest[
		"https://api.waifulabs.com/generate_big",
		<|"Method" -> "Post", "Body" -> ExportString[settings, "JSON"]|>
	];
	girl = Import[request, "RawJSON"]["girl"];
	ImportString[girl, "Base64"]
]
WaifuLabGrid[] := Module[
	{i1, i2, i3, i4},
	{i1, i2, i3} = RandomInteger[300000, 3];
	i4 = WaifuLab[i1, i2, i3];
	Echo[{i1, i2, i3}, "Seeds: "];
	Row[{i4, Column[WaifuLab /@ {i1, i2, i3}]}]
]
WaifuLabGrid[i1_, i2_, i3_] := Module[
	{i4 = WaifuLab[i1, i2, i3]},
	Echo[{i1, i2, i3}, "Seeds: "];
	Row[{i4, Column[WaifuLab /@ {i1, i2, i3}]}]
]


(* ::Section:: *)
(*Additional*)


End[];
SetAttributes[
	{ },
	{Protected, ReadProtected}
];
EndPackage[]
