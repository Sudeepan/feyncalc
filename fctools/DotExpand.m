(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* :Title: DotExpand *)

(* :Author: Frederik Orellana *)

(* ------------------------------------------------------------------------ *)
(* :History: created February 26th 2003 *)
(* ------------------------------------------------------------------------ *)

(* :Summary: Expand DOT products *)

(* ------------------------------------------------------------------------ *)

MyBeginPackage["HighEnergyPhysics`fctools`DotExpand`",
             "HighEnergyPhysics`FeynCalc`"];


DotExpand::"usage" =
    "DotExpand[expr] expands DOT products in expr.";

(* ------------------------------------------------------------------------ *)

Begin["`Private`"];

MakeContext[(*DOT, *)NonCommFreeQ, NonCommQ];

DotExpand[expr_] :=
    expr //. {DOT[a___, b_ + c_, d___] :> Distribute[DOT[a, b + c, d]],
  DOT[a___, b_*c_, d___] :> b*DOT[a, c, d] /; NonCommFreeQ[b],
  DOT[a___, b_, d___] :> b*DOT[a, d] /; NonCommFreeQ[b]} /.
  DOT[] :> Sequence[];

End[]; MyEndPackage[];
(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
If[$VeryVerbose > 0,WriteString["stdout", "DotExpand | \n "]];
Null