Shader "Hidden/PixelShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_PixelWidth("Pixel width", float) = 1.0
		_PixelHeight("Pixel height", float) = 1.0
		_ScreenWidth("Screen width", float) = 1.0
		_ScreenHeight("Screen height", float) = 1.0
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				half4 vertex : POSITION;
				half2 uv : TEXCOORD0;
			};

			struct v2f
			{
				half2 uv : TEXCOORD0;
				half4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			half _PixelWidth;
			half _PixelHeight;
			half _ScreenWidth;
			half _ScreenHeight;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				half dx = _PixelWidth * (1. / _ScreenWidth);
				half dy = _PixelHeight * (1. / _ScreenHeight);
				half2 coord = half2(dx*floor(i.uv.x / dx), dy * floor(i.uv.y / dy));
				col = tex2D(_MainTex, coord);
				return col;
			}
			ENDCG
		}
	}
}
