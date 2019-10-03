(* ::Package:: *)

(* ::Section:: *)
(*Declare*)


WaifuLab::usage = "";
WaifuLabGrid::usage = "";
ThisWaifuDoesNotExist::usage = "";
Begin["`Private`"];


(* ::Section:: *)
(*WaifuLabs*)


(* ::Item:: *)
(*Model: StyleGAN*)


(* ::Item:: *)
(*WaifuLabs: https://waifulabs.com/*)


$WaifuLabsIndexMax = 300000;


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
];


WaifuLabGrid[] := Module[
	{i1, i2, i3, i4, grid},
	{i1, i2, i3} = RandomInteger[$WaifuLabsIndexMax, 3];
	i4 = WaifuLab[i1, i2, i3];
	Echo[{i1, i2, i3}, "Seeds: "];
	grid = {
		{i4, SpanFromLeft, SpanFromLeft, WaifuLab@i1},
		{SpanFromAbove, SpanFromBoth, SpanFromBoth, WaifuLab@i2},
		{SpanFromAbove, SpanFromBoth, SpanFromBoth, WaifuLab@i3}
	};
	GraphicsGrid[grid, Frame -> All]
];
WaifuLabGrid[i1_, i2_, i3_] := Module[
	{i4 = WaifuLab[i1, i2, i3]},
	Echo[{i1, i2, i3}, "Seeds: "];
	grid = {
		{i4, SpanFromLeft, SpanFromLeft, WaifuLab@i1},
		{SpanFromAbove, SpanFromBoth, SpanFromBoth, WaifuLab@i2},
		{SpanFromAbove, SpanFromBoth, SpanFromBoth, WaifuLab@i3}
	};
	GraphicsGrid[grid, Frame -> All]
];


(* ::Section:: *)
(*ThisWaifuDoesnotExist*)


(* ::Item:: *)
(*Model: StyleGAN*)


(* ::Item:: *)
(*ThisWaifuDoesNotExist: https://www.thiswaifudoesnotexist.net*)


$ThisWaifuDoesNotExistTextRange = {0, 125254};
$ThisWaifuDoesNotExistImageRange = {0, 200000 - 1};


ThisWaifuDoesNotExist[a_Integer : -1, OptionsPattern[]] := Block[
	{apiImage, n},
	(*apiText=StringTemplate["https://www.thiswaifudoesnotexist.net/snippet-`1`.txt"];*)
	apiImage = StringTemplate["https://www.thiswaifudoesnotexist.net/example-`1`.jpg"];
	n = If[
		0 < a < Last@$ThisWaifuDoesNotExistImageRange,
		a,
		RandomInteger@$ThisWaifuDoesNotExistImageRange
	];
	Import@apiImage[n]
];


(* ::Section:: *)
(*Additional*)


End[];
SetAttributes[
	{ },
	{Protected, ReadProtected}
];
