Shader "Custom/SimpleDepthFog"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_FogColor("Fog Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_FogPower("Fog Power", Range(-300.0, -1.0)) = -1.0
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST, _FogColor;;
			float _FogPower;
			
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float depth : ANY;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				float3 mv = UnityObjectToViewPos(v.vertex);
				o.depth = mv.z;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				
				return fixed4(lerp(col, _FogColor, saturate(i.depth / _FogPower)).rgb, 1.0);
			}
			ENDCG
		}
	}
}
