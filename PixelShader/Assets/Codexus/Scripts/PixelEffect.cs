using UnityEngine;
using System.Collections;

namespace Codexus
{
    [ExecuteInEditMode]
    [RequireComponent(typeof(Camera))]
    public class PixelEffect : MonoBehaviour
    {
        [Header("Pixels size")]
        [Range(1.0f, 20f)]
        public float pixelWidth = 0.05f;
        [Range(1.0f, 20f)]
        public float pixelHeight = 0.05f;

        private Material pixelMaterial = null;

        void SetMaterial()
        {
            pixelMaterial = new Material(Shader.Find("Hidden/PixelShader"));
        }

        void OnEnable()
        {
            SetMaterial();
        }

        void OnDisable()
        {
            pixelMaterial = null;
        }

        void OnRenderImage(RenderTexture source, RenderTexture destination)
        {

            if (pixelMaterial == null)
            {
                Graphics.Blit(source, destination);
                return;
            }

            pixelMaterial.SetFloat("_PixelWidth", pixelWidth);
            pixelMaterial.SetFloat("_PixelHeight", pixelHeight);
            pixelMaterial.SetFloat("_ScreenWidth", source.width);
            pixelMaterial.SetFloat("_ScreenHeight", source.height);

            Graphics.Blit(source, destination, pixelMaterial);
        }
    }

}
