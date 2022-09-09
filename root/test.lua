--
-- Pool: Graphics
--

local Pool =
{
	{
		Group = "Category: Render",
		Class =
		{
			{
				"type":"bool",
				"name":"Antialiasing",
				"path":"Developer/FeatureToggles/Antialiasing",
				Flag =
				{
					"onfalse":[
					{
						{ "type":"bool", "path":"DLSS/Enable", set = false, onlyif = true },
						{ "type":"sStringList", "path":"graphics/dynamicresolution/DLSS", set = "Off" },
					},
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Ambient Occlusion",
				"path":"Developer/FeatureToggles/SSAO",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/advanced/AmbientOcclusion", onlyif = "Off", redraw = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/advanced/AmbientOcclusion",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Global Illumination",
				"path":"Developer/FeatureToggles/GlobalIllumination",
			},
			{
				"type":"bool",
				"name":"(Distant Rendering)",
				"path":"Developer/FeatureToggles/DistantGI",
				Flag = 
				{
					Line = 50,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Distant Shadow (Blur)",
				"path":"Rendering/GlobalIllumination/DistantShadowBlur",
				Flag =
				{
					vDef = 5.000000,
					vMin = 0.000000,
					vMax = 100.000000,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Distant Shadow (Force)",
				"path":"Rendering/GlobalIllumination/DistantShadowForce",
				Flag =
				{
					vDef = 0.600000,
					vMin = 0.400000,
					vMax = 1.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Screen Space Reflection",
				"path":"Developer/FeatureToggles/ScreenSpaceReflection",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/advanced/ScreenSpaceReflectionsQuality", onlyif = "Off", redraw = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/advanced/ScreenSpaceReflectionsQuality",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"(Rain)",
				"path":"Developer/FeatureToggles/ScreenSpaceRain",
				Flag = 
				{
					Void = 43,
					"onfalse":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/Weather", set = false },
					},
				},
			},
			{
				"type":"bool",
				"name":"(Heat Haze)",
				"path":"Developer/FeatureToggles/ScreenSpaceHeatHaze",
				Flag =
				{
					Line = 108,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"(Rain Map)",
				"path":"Developer/FeatureToggles/RainMap",
				Flag = 
				{
					Void = 43,
				},
			},
			{
				"type":"bool",
				"name":"(Underwater)",
				"path":"Developer/FeatureToggles/ScreenSpaceUnderwater",
				Flag =
				{
					Line = 80,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"(Weather Effect)",
				"path":"Developer/FeatureToggles/Weather",
				Flag =
				{
					Void = 43,
					"ontrue":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/ScreenSpaceRain", set = true },
						{ "type":"bool", "path":"Developer/FeatureToggles/RainMap", set = true },
					},
				},
			},
			{
				"type":"bool",
				"name":"(Planar Reflection)",
				"path":"Developer/FeatureToggles/ScreenSpacePlanarReflection",
				Flag =
				{
					Line = 38,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Volumetric Fog",
				"path":"Developer/FeatureToggles/VolumetricFog",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/advanced/VolumetricFogResolution", onlyif = "Off", redraw = true },
					},
					"onfalse":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/DistantVolFog", set = false },
					},
				},
			},
			{
				"type":"bool",
				"name":"(Distant Rendering)",
				"path":"Developer/FeatureToggles/DistantVolFog",
				Flag =
				{
					Line = 85,
					"ontrue":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/VolumetricFog", set = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/advanced/VolumetricFogResolution",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"Experimental Fog",
				"path":"Rendering/UseExperimentalVolFog",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"bool",
				"name":"Simple Fog (Distant)",
				"path":"Developer/FeatureToggles/DistantFog",
				Flag =
				{
					Line = 38,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Volumetric Clouds",
				"path":"Developer/FeatureToggles/VolumetricClouds",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/advanced/VolumetricCloudsQuality", onlyif = "Off", redraw = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/advanced/VolumetricCloudsQuality",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Noise Scale",
				"path":"Editor/VolumetricClouds/NoiseScale",
				Flag =
				{
					vDef = 1.100000,
					vMin = 0.000000,
					vMax = 1.500000,
					vRes = "%.2f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Coverage Scale",
				"path":"Editor/VolumetricClouds/CoverageScale",
				Flag =
				{
					vDef = 1.300000,
					vMin = 0.000000,
					vMax = 1.500000,
					vRes = "%.2f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Level of Detail",
				"path":"DeveloperExtras/BoolTrue",
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"LOD Preset",
				"path":"graphics/advanced/LODPreset",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Dynamic Decals",
				"path":"Developer/FeatureToggles/DynamicDecals",
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Max Dynamic Decals",
				"path":"graphics/advanced/MaxDynamicDecals",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Hide Distance",
				"path":"LevelOfDetail/DynamicDecalsHideDistance",
				Flag =
				{
					vDef = 20.000000,
					vMin = 0.000000,
					vMax = 100.000000,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Hide Distance (Statics?)",
				"path":"LevelOfDetail/DecalsHideDistance",
				Flag =
				{
					vDef = 30.000000,
					vMin = 0.000000,
					vMax = 100.000000,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Constrast Adaptive Sharpening",
				"path":"Developer/FeatureToggles/ConstrastAdaptiveSharpening",
			},
			{
				"type":"separator",
			},
			{
				"type":"sIntList",
				"name":"Anisotropy",
				"path":"graphics/advanced/Anisotropy",
				Flag =
				{
					Draw = 0,
					Both = 0,
				},
			},
			{
				"type":"sStringList",
				"name":"Color Precision",
				"path":"graphics/advanced/ColorPrecision",
				Flag =
				{
					Draw = 0,
					Both = 1,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Mirror Quality",
				"path":"graphics/advanced/MirrorQuality",
				Flag =
				{
					Draw = 0,
				},
			},
		},
	},
	{
		Group = "Category: Shadows",
		Class =
		{
			{
				"type":"bool",
				"name":"Contact Shadows",
				"path":"Developer/FeatureToggles/ContactShadows",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/advanced/ContactShadows", set = true, redraw = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/advanced/ContactShadows", set = false, redraw = true },
					},
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Local Shadows",
				"path":"Developer/FeatureToggles/LocalShadows",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/advanced/LocalShadowsQuality", onlyif = "Off", redraw = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/advanced/LocalShadowsQuality",
				Flag =
				{
					Draw = 0,
					Both = 0,
				},
			},
			{
				"type":"sStringList",
				"name":"Mesh Quality",
				"path":"graphics/advanced/ShadowMeshQuality",
				Flag =
				{
					Draw = 0,
					Both = 1,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Distant Shadows",
				"path":"Developer/FeatureToggles/DistantShadows",
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Shadow Resolution",
				"path":"graphics/advanced/DistantShadowsResolution",
				Flag = 
				{
					Draw = 0,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Cascade Shadows",
				"path":"DeveloperExtras/BoolTrue",
			},
			{
				"type":"spacing",
			},
			{
				"type":"sStringList",
				"name":"Shadow Range",
				"path":"graphics/advanced/CascadedShadowsRange",
				Flag =
				{
					Draw = 0,
					Both = 0,
				},
			},
			{
				"type":"sStringList",
				"name":"Shadow Resolution",
				"path":"graphics/advanced/CascadedShadowsResolution",
				Flag =
				{
					Draw = 0,
					Both = 1,
				},
			},
		},
	},
	{
		Group = "Category: Filters",
		Class =
		{
			{
				"type":"bool",
				"name":"Bloom",
				"path":"Developer/FeatureToggles/Bloom",
				Flag =
				{
					"onfalse":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/ImageBasedFlares", set = false },
						{ "type":"sBool", "path":"graphics/basic/LensFlares", set = false, redraw = true },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Lens Flare",
				"path":"Developer/FeatureToggles/ImageBasedFlares",
				Flag =
				{
					Void = 43,
					"ontrue":[
					{
						{ "type":"bool", "path":"Developer/FeatureToggles/Bloom", set = true },
						{ "type":"sBool", "path":"graphics/basic/LensFlares", set = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/basic/LensFlares", set = false },
					},
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Motion Blur",
				"path":"Developer/FeatureToggles/MotionBlur",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/basic/MotionBlur", onlyif = "Off", redraw = true },
					},
				},
			},
			{
				"type":"sStringList",
				"name":"Render Quality",
				"path":"graphics/basic/MotionBlur",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Film Grain",
				"path":"Developer/FeatureToggles/FilmGrain",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/basic/FilmGrain", set = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/basic/FilmGrain", set = false },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Depth of Field",
				"path":"Developer/FeatureToggles/DepthOfField",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/basic/DepthOfField", set = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/basic/DepthOfField", set = false },
					},
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Chromatic Aberration",
				"path":"Developer/FeatureToggles/ChromaticAberration",
				Flag =
				{
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/basic/ChromaticAberration", set = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/basic/ChromaticAberration", set = false },
					},
				},
			},
		},
	},
	{
		Group = "Category: Scaling",
		Class =
		{
			{
				"type":"sBool",
				"name":"Static Resolution Scaling (SRS)",
				"path":"graphics/dynamicresolution/StaticResolutionScaling",
				Flag =
				{
					Draw = 0,
					Show = true,
					"ontrue":[
					{
						{ "type":"sStringList", "path":"graphics/dynamicresolution/DLSS", set = "Off" },
					},
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"sInt",
				"name":"Internal Render Percentage",
				"path":"graphics/dynamicresolution/SRS_Resolution",
				Flag =
				{
					Draw = 30,
					Void = 25,
					Step = { 25,50,75,100,125,150,175,200,225,250 },
					Base = 100,
					vMin = 25,
					vMax = 250,
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"sStringList",
				"name":"NVidia Deep Learning Super Sampling (DLSS)",
				"path":"graphics/dynamicresolution/DLSS",
				Flag =
				{
					Draw = 30,
					Void = 10,
					"ontrue":[
					{
						--{ "type":"sStringList", "path":"graphics/dynamicresolution/FSR", set = false },
						--{ "type":"sBool", "path":"graphics/dynamicresolution/StaticResolutionScaling", set = false },
						--{ "type":"bool", "path":"Developer/FeatureToggles/Antialiasing", set = true },
					},
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Sharpen Filter",
				"path":"DLSS/Sharpness",
				Flag =
				{
					Void = 25,
					Step = { 0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0 },
					Base = 0.000000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"sFloat",
				"name":"Sharpen Filter",
				"path":"graphics/dynamicresolution/DLSS_Sharpness",
				Flag =
				{
					Void = 25,
					Step = { 0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0 },
					vDef = 0.000000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.1f%%",
				},
			},
		},
	},
	{
		Group = "Category: Character",
		Class =
		{
			{
				"type":"bool",
				"name":"Improved Facial Lighting",
				"path":"Developer/FeatureToggles/RuntimeTangentUpdate",
				Flag =
				{
					Draw = 0,
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/advanced/FacialTangentUpdates", set = true, redraw = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/advanced/FacialTangentUpdates", set = false, redraw = true },
					},
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Show Hair",
				"path":"Developer/FeatureToggles/Hair",
				Flag =
				{
					Note = 'all Characters',
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Reference Implementation",
				"path":"Editor/Characters/Hair/UseReferenceImplementation",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Modified Local Light Intensity",
				"path":"Editor/Characters/Hair/HACKS/AAAA_HACK_hairModifiedLocalLightIntensity",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Roughness Factor",
				"path":"Editor/Characters/Hair/RoughnessFactor",
				Flag =
				{
					Void = 61,
					vDef = 1.000000,
					vMin = 0.010000,
					vMax = 3.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Albedo Multiplier",
				"path":"Editor/Characters/Hair/AlbedoMultiplier",
				Flag =
				{
					Void = 61,
					vDef = 0.600000,
					vMin = 0.000000,
					vMax = 10.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Additional Area Roughness",
				"path":"Editor/Characters/Hair/AdditionalAreaRoughness",
				Flag =
				{
					Void = 61,
					vDef = 0.100000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"TRT Exp Bias",
				"path":"Editor/Characters/Hair/TRT_Params/EXP_BIAS",
				Flag =
				{
					Void = 61,
					vDef = 16.500000,
					vMin = 0.000000,
					vMax = 20.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"TRT Exp Scale",
				"path":"Editor/Characters/Hair/TRT_Params/EXP_SCALE",
				Flag =
				{
					Void = 61,
					vDef = 17.000000,
					vMin = 0.000000,
					vMax = 20.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"Local Contact Shadows",
				"path":"Editor/Characters/Hair/UseLocalContactShadowsOnHair",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Global Contact Shadows",
				"path":"Editor/Characters/Hair/UseGlobalContactShadowsOnHair",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Contact Shadow Clamp",
				"path":"Editor/Characters/Hair/ContactShadowClamp",
				Flag =
				{
					Void = 61,
					vDef = 0.350000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Subsurface Scattering",
				"path":"Developer/FeatureToggles/CharacterSubsurfaceScattering",
			},
			{
				"type":"spacing",
			},
			{
				"type":"bool",
				"name":"Subsurface Translucency",
				"path":"Developer/FeatureToggles/CharacterSubsurfaceTranslucency",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Specular Weight",
				"path":"Editor/Characters/Skin/SubsurfaceSpecularTintWeight",
				Flag =
				{
					vDef = 0.300000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Specular Tint (Red)",
				"path":"Editor/Characters/Skin/SubsurfaceSpecularTint_R",
				Flag =
				{
					vDef = 0.125000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.3f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Specular Tint (Green)",
				"path":"Editor/Characters/Skin/SubsurfaceSpecularTint_G",
				Flag =
				{
					vDef = 0.260000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Specular Tint (Blue)",
				"path":"Editor/Characters/Skin/SubsurfaceSpecularTint_B",
				Flag =
				{
					vDef = 0.290000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Rim Enhancement",
				"path":"Developer/FeatureToggles/CharacterRimEnhancement",
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Character Fresnel",
				"path":"Editor/Characters/RimEnhancement/GlobalCharacterFresnel",
				Flag =
				{
					vDef = 1.500000,
					vMin = 0.000000,
					vMax = 100.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Character Fresnel (RayTracing)",
				"path":"Editor/Characters/RimEnhancement_RayTracing/GlobalCharacterFresnel",
				Flag =
				{
					vDef = 1.500000,
					vMin = 0.000000,
					vMax = 100.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"Light Blockers",
				"path":"Developer/FeatureToggles/CharacterLightBlockers",
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Influence",
				"path":"Editor/Characters/RimEnhancement/LightBlockerInfluence",
				Flag =
				{
					vDef = 0.700000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Influence (RayTracing)",
				"path":"Editor/Characters/RimEnhancement_RayTracing/LightBlockerInfluence",
				Flag =
				{
					vDef = 0.700000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.1f",
				},
			},
		},
	},
	{
		Group = "Category: Raytracing",
		Class =
		{
			{
				"type":"bool",
				"name":"RayTracing",
				"path":"RayTracing/Enable",
				Flag =
				{
					Draw = 0,
					"ontrue":[
					{
						{ "type":"sBool", "path":"graphics/raytracing/RayTracing", set = true, redraw = true },
					},
					"onfalse":[
					{
						{ "type":"sBool", "path":"graphics/raytracing/RayTracing", set = false, redraw = true },
					},
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"sStringList",
				"name":"Render Lighting",
				"path":"graphics/raytracing/RayTracedLighting",
				Flag =
				{
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"Ambient Occlusion",
				"path":"DeveloperExtras/BoolTrue",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Radius Near",
				"path":"RayTracing/AmbientOcclusionRadiusNear",
				Flag =
				{
					Void = 61,
					vDef = -1.000000,
					vMin = -1.000000,
					vMax = 1000.000000,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Radius Far",
				"path":"RayTracing/AmbientOcclusionRadiusFar",
				Flag =
				{
					Void = 61,
					vDef = -1.000000,
					vMin = -1.000000,
					vMax = 50000.000000,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Diffuse Illumination Modulation",
				"path":"RayTracing/DiffuseIlluminationAOModulation",
				Flag =
				{
					Void = 61,
					vDef = 0.400000,
					vMin = 0.000000,
					vMax = 10.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Emissive Range Scale",
				"path":"RayTracing/EmissiveRangeScale",
				Flag =
				{
					Void = 61,
					vDef = 10.000000,
					vMin = -100.000000,
					vMax = 100.000000,
					vRes = "%.1f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"sBool",
				"name":"Render Reflections",
				"path":"graphics/raytracing/RayTracedReflections",
				Flag =
				{
					Show = true,
					Void = 28,
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"Use Screen Space",
				"path":"RayTracing/Reflection/UseScreenSpaceData",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Roughness Override",
				"path":"RayTracing/Reflection/RoughnessOverride",
				Flag =
				{
					Void = 61,
					vDef = 0.000000,
					vMin = 0.000000,
					vMax = 10.000000,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Roughness Threshold",
				"path":"RayTracing/Reflection/RoughnessThreshold",
				Flag =
				{
					Void = 61,
					vDef = 0.990000,
					vMin = 0.000000,
					vMax = 1.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"sBool",
				"name":"Render Sun Shadows",
				"path":"graphics/raytracing/RayTracedSunShadows",
				Flag =
				{
					Show = true,
					Void = 28,
					Draw = 0,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"float",
				"name":"Sun Angular Size",
				"path":"RayTracing/SunAngularSize",
				Flag =
				{
					Void = 61,
					vDef = 0.500000,
					vMin = 0.000000,
					vMax = 10.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Sun Visibility",
				"path":"RayTracing/SunVisibility",
				Flag =
				{
					Void = 61,
					vDef = 1.000000,
					vMin = 0.000000,
					vMax = 10.000000,
					vRes = "%.2f",
				},
			},
			{
				"type":"largeseparator",
			},
			{
				"type":"bool",
				"name":"NVidia RealTime Denoisers",
				"path":"RayTracing/EnableNRD",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"separator",
			},
			{
				"type":"bool",
				"name":"Scaling Compensation",
				"path":"RayTracing/NRD/EnableScalingCompensation",
				Flag =
				{
					Void = 43,
				},
			},
			{
				"type":"spacing",
			},
			{
				"type":"float",
				"name":"Diffuse Denoising Radius",
				"path":"RayTracing/NRD/DiffuseDenoisingRadius",
				Flag =
				{
					Void = 61,
					vDef = 60.000000,
					vMin = 0.000000,
					vMax = 100.000000,
				},
			},
		},
	},
}

return Pool