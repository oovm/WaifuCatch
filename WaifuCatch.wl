(* ::Package:: *)

(* ::Subsection::Closed:: *)
(*Temp Loading Flag Code*)


Temp`PackageScope`WaifuCatchLoading`Private`$PackageLoadData=
  If[#===None, <||>, Replace[Quiet@Get@#, Except[_?OptionQ]-><||>]]&@
    Append[
      FileNames[
        "LoadInfo."~~"m"|"wl",
        FileNameJoin@{DirectoryName@$InputFileName, "Config"}
        ],
      None
      ][[1]];
Temp`PackageScope`WaifuCatchLoading`Private`$PackageLoadMode=
  Lookup[Temp`PackageScope`WaifuCatchLoading`Private`$PackageLoadData, "Mode", "Primary"];
Temp`PackageScope`WaifuCatchLoading`Private`$DependencyLoad=
  TrueQ[Temp`PackageScope`WaifuCatchLoading`Private`$PackageLoadMode==="Dependency"];


(* ::Subsection:: *)
(*Main*)


If[Temp`PackageScope`WaifuCatchLoading`Private`$DependencyLoad,
  If[!TrueQ[Evaluate[Symbol["`WaifuCatch`PackageScope`Private`$LoadCompleted"]]],
    Get@FileNameJoin@{DirectoryName@$InputFileName, "WaifuCatchLoader.wl"}
    ],
  If[!TrueQ[Evaluate[Symbol["WaifuCatch`PackageScope`Private`$LoadCompleted"]]],
    <<WaifuCatch`WaifuCatchLoader`,
   BeginPackage["WaifuCatch`"];
   EndPackage[];
   ]
  ]
