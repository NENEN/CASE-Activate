within ;
model HeatCapacitorPCMLike00
  "Lumped thermal element storing heat with temperature-varying capacitance"
 Modelica.SIunits.HeatCapacity C "Heat capacity of element (= cp*m)";
 Modelica.SIunits.Temperature T(start = 293.15+40, displayUnit = "degC")
    "Temperature of element";
 Modelica.SIunits.TemperatureSlope der_T(start = 0)
    "Time derivative of temperature (= der(T))";
// Modelica.SIunits.Mass m_h20;
// Modelica.SIunits.Mass m_PCM;

//   extends Modelica.Thermal.HeatTransfer.Components.HeatCapacitor;
  import Modelica.Media.Water.ConstantPropertyLiquidWater;
//  import Modelica.SIunits.Temperature;
//  import Modelica.SIunits.Mass;
//  import Modelica.SIUnits.Volume;
//  import Modelica.SIunits.Area;
//  import SpecificHeat = Modelica.SIunits.SpecificHeatCapacity;

  type HeatFusion = Real(unit="kJ/kg", min=0.010);

//  Modelica.SIunits.Volume V
//    "functioning volume of storage element, in water and PCM";

  parameter Real cp_h2o = 4.177 "spec heat cap water";
  parameter Real cp_PCM = 2.9 "spec heat cap paraffin";
  parameter Real rho_h2o = 995 "density water";
  parameter Real rho_PCM = 900 "density PCM";
  parameter Real V_tank = 1 "density PCM";

  parameter Real fracPCM_vol = 0.6 "fraction of volume that is PCM";
  parameter HeatFusion hfg_pcm = 200;
  parameter Modelica.SIunits.Temperature T_sc = 293+65
    "lowest subcooling temperature";
  parameter Modelica.SIunits.Temperature T_melt = 293+65+6
    "highest melting temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port annotation(Placement(transformation(origin = {0,-100}, extent = {{-10,-10},{10,10}}, rotation = 90)));
equation
  T = port.T;
  der_T = der(T);
  C * der(T) = port.Q_flow;
if T<T_sc then
  C = (cp_h2o*(V_tank*(1-fracPCM_vol)*rho_h2o)) + (cp_PCM*(V_tank*(fracPCM_vol)*rho_PCM));
  //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
//  C = (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(2.9/4.177)*(V*(fracPCM))*(Modelica.Thermal.FluidHeatFlow.Media.Water.rho*(900/995)));
  //constant fractions are used to set the cp and rho values for paraffin relative to water. source: engineering toolbox online.
  elseif T>T_melt then
  C = (cp_h2o*(V_tank*(1-fracPCM_vol)*rho_h2o)) + (cp_PCM*(V_tank*(fracPCM_vol)*rho_PCM));

    //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
//  C = (Modelica.Thermal.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(2.9/4.177)*(V*(fracPCM))*(Modelica.Thermal.FluidHeatFlow.Media.Water.rho*(900/995)));
  //constant fractions are used to set the cp and rho values for paraffin relative to water. source: engineering toolbox online.

else
  C = (cp_h2o*(V_tank*(1-fracPCM_vol)*rho_h2o)) + ((hfg_pcm/(T_melt-T_sc))*V_tank*fracPCM_vol);

  //  C = (cp_const*(V*(1-fracPCM))*d_const) + (cp_const*(2.9/4.177)*(V*(fracPCM))*(d_const*(900/995)));
  //C = (Modelica.Thermal.FluidHeatFlow.Media.Water.cp*(V*(1-fracPCM))*Modelica.Thermal.FluidHeatFlow.Media.Water.rho) + ((hfg_pcm/(T_melt-T_sc))*V*fracPCM);

end if;
  //  try = Modelica.Thermal.FluidHeatFlow.Media.Water.rho;
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-150,110},{150,70}}, textString = "%name", lineColor = {0,0,255}),Polygon(points = {{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,33},{44,41},{36,57},{26,65},{0,67}}, lineColor = {160,160,164}, fillColor = {192,192,192},
            fillPattern =                                                                                                    FillPattern.Solid),Polygon(points = {{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,-77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,-73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},{-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,27},{-48,35},{-44,45},{-40,57},{-58,35}}, lineColor = {0,0,0}, fillColor = {160,160,164},
            fillPattern =                                                                                                    FillPattern.Solid),Text(extent = {{-69,7},{71,-24}}, lineColor = {0,0,0}, textString = "%C")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={  Polygon(points = {{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,33},{44,41},{36,57},{26,65},{0,67}}, lineColor = {160,160,164}, fillColor = {192,192,192},
            fillPattern =                                                                                                    FillPattern.Solid),Polygon(points = {{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,-77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,-73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},{-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,27},{-48,35},{-44,45},{-40,57},{-58,35}}, lineColor = {0,0,0}, fillColor = {160,160,164},
            fillPattern =                                                                                                    FillPattern.Solid),Ellipse(extent = {{-6,-1},{6,-12}}, lineColor = {255,0,0}, fillColor = {191,0,0},
            fillPattern =                                                                                                    FillPattern.Solid),Text(extent = {{11,13},{50,-25}}, lineColor = {0,0,0}, textString = "T"),Line(points = {{0,-12},{0,-96}}, color = {255,0,0})}), Documentation(info = "<HTML>
<p>
This is copied from:
This is a generic model for the heat capacity of a material.
No specific geometry is assumed beyond a total volume with
uniform temperature for the entire volume.
Furthermore, it is assumed that the heat capacity
is constant (independent of temperature).
</p>
<p>
The temperature T [Kelvin] of this component is a <b>state</b>.
A default of T = 25 degree Celsius (= SIunits.Conversions.from_degC(25))
is used as start value for initialization.
This usually means that at start of integration the temperature of this
component is 25 degrees Celsius. You may, of course, define a different
temperature as start value for initialization. Alternatively, it is possible
to set parameter <b>steadyStateStart</b> to <b>true</b>. In this case
the additional equation '<b>der</b>(T) = 0' is used during
initialization, i.e., the temperature T is computed in such a way that
the component starts in <b>steady state</b>. This is useful in cases,
where one would like to start simulation in a suitable operating
point without being forced to integrate for a long time to arrive
at this point.
</p>
<p>
Note, that parameter <b>steadyStateStart</b> is not available in
the parameter menu of the simulation window, because its value
is utilized during translation to generate quite different
equations depending on its setting. Therefore, the value of this
parameter can only be changed before translating the model.
</p>
<p>
This component may be used for complicated geometries where
the heat capacity C is determined my measurements. If the component
consists mainly of one type of material, the <b>mass m</b> of the
component may be measured or calculated and multiplied with the
<b>specific heat capacity cp</b> of the component material to
compute C:
</p>
<pre>
   C = cp*m.
   Typical values for cp at 20 degC in J/(kg.K):
      aluminium   896
      concrete    840
      copper      383
      iron        452
      silver      235
      steel       420 ... 500 (V2A)
      wood       2500
</pre>
</html>"),
    uses(Modelica(version="3.2.1")));
end HeatCapacitorPCMLike00;
