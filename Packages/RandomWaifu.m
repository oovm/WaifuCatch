RandomWaifu::usage = "";


Begin["`Private`"];

$RandomWaifuModels = {
	"E1", "E2", "F1", "F2"
};

Options[RandomWaifu] = {
	MetaInformation -> True,
	TargetDevice -> "GPU",
	NetModel -> "F1"
};
RandomWaifu[o : OptionsPattern[]] := RandomWaifu[
	RandomVariate[NormalDistribution[], 100], o
];
RandomWaifu[n_Integer, o : OptionsPattern[]] := Block[
	{data, dist},
	If[n < 1, Return[]];
	dist = NormalDistribution[];
	data = RandomVariate[dist, If[n == 1, 100, {n, 100}], 100];
	RandomWaifu[data, o]
];
RandomWaifu[list_List, OptionsPattern[]] := Block[
	{eval, results, info},
	If[
		!MemberQ[$RandomWaifuModels, OptionValue@NetModel],
		Message[Import::nffil, OptionValue@NetModel, "loading"];
		Return[]
	];
	eval = WaifuLoadingModel[OptionValue@NetModel];
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