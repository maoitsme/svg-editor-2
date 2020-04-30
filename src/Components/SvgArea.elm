module Components.SvgArea exposing (svgArea)

import Svg exposing (Svg)
import Svg.Events as Se
import Svg.Attributes as Sa

import CustomTypes exposing (Model, Msg(..), ShapeType(..))

import Components.Handles exposing (svgHandle)

import Functions.CustomEvents exposing(propagationMouseDown)
import Functions.ConvertDataToSvg exposing (convertDataToSvg)

svgArea : Model -> Svg Msg
svgArea model =
    let width = String.fromFloat model.svgProps.width
        height = String.fromFloat model.svgProps.height
    in
    Svg.svg 
        [ Sa.width width, Sa.height height
        , Sa.class "canvas"
        , case model.selectHover.shape of 
                Selector -> propagationMouseDown <| (EditModel model, True)
                _ -> Se.onMouseDown <| NewShape <| Just model.selectHover.shape
        ] 
        [ Svg.g [] <| convertDataToSvg model
        , case model.selectHover.shape of
            Selector -> svgHandle model "True"
            _ -> Svg.g [] []
        ]
