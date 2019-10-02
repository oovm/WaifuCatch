RandomWaifu::usage = "";


Begin["`Private`"];

Options[RandomWaifu] = {
	MetaInformation -> True,
	TargetDevice -> "GPU",
	NetModel -> "F1"
};
RandomWaifu[o : OptionsPattern[]] := RandomWaifu[
	RandomVariate[NormalDistribution[], 100], o
];
RandomWaifu[n_Integer, o : OptionsPattern[]] := Module[
	{data},
	If[n < 1, Return[]];
	data = If[
		n == 1,
		RandomVariate[NormalDistribution[], 100],
		RandomVariate[NormalDistribution[], {n, 100}]
	];
	RandomWaifu[data, o]
];
RandomWaifu[list_List, OptionsPattern[]] := Module[
	{eval, results, info},
	eval = Switch[OptionValue@NetModel,
		"F1", WaifuLoadingModel["DCGAN-F1"],
		"F2", WaifuLoadingModel["DCGAN-F1"],
		"G1", WaifuLoadingModel["DCGAN-F1"],
		_, Message[Import::nffil, OptionValue@NetModel, "loading"]; Return[]
	];
	results = eval[list, TargetDevice -> OptionValue@TargetDevice];
	If[!TrueQ[OptionValue@MetaInformation], Return[results]];
	info = <|
		"Factory" -> OptionValue@NetModel,
		"Gene" -> NumericArray[#1, "Real32"],
		"Result" -> #2
	|>&;
	If[
		Length@results == 0,
		info[list, results],
		info @@@ Transpose[{list, results}]
	]
];

End[]