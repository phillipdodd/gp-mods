using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;
using UnityEngine.Events;

public class Hittable : MonoBehaviour
{
    public static List<Hittable> All = new List<Hittable>();
    public static Dictionary<Transform, Hittable> Dict = new Dictionary<Transform, Hittable>();

    public UnityEvent OnHit = new UnityEvent();

    [ToggleLeft]
    public bool OnlySpecificProjectile = false;
    [ShowIf("OnlySpecificProjectile")] public int SpecificProjectileNumber = 0;

    public int lastHitDamage;

    [ToggleLeft]
    public bool CanTakeCrit = false;
    [ToggleLeft]
    public bool ShakeOnDamage = false;
    [ShowIf("ShakeOnDamage")]
    public Transform ShakeObj;
    [ToggleLeft]
    public bool ShowDamageNumber = false;
    [ShowIf("ShowDamageNumber")]
    public float damageNumberSpot = 1.5f;

    public bool DoDebug = false;

    private void OnEnable()
    {
        if (!All.Contains(this)) All.Add(this);
        if (!Dict.ContainsKey(transform)) Dict.Add(transform, this);
    }

    private void OnDisable()
    {
        if (All.Contains(this)) All.Remove(this);
        if (Dict.ContainsKey(transform)) Dict.Remove(transform);
    }

    public Animator anim;

    public bool IsEnemy = true;
    public string[] possibleAnimations;

    private int[] animationHashes;
    private int lastPlayedAnimation = 0;
    public void Awake()
    {
        if (possibleAnimations != null)
        {
            animationHashes = new int[possibleAnimations.Length];
            for (int i = 0; i < possibleAnimations.Length; i++)
            {
                animationHashes[i] = Animator.StringToHash(possibleAnimations[i]);
            }
        }
    }

    void OnDrawGizmosSelected()
    {
        if (ShowDamageNumber)
        {
            Gizmos.color = Color.yellow;
            Gizmos.DrawWireSphere(transform.Above(damageNumberSpot), 0.15f);
        }
    }

    [Button]
    public void DoHit()
    {
        if (DoDebug) Debug.Log("Do hit");
        lastPlayedAnimation++;
        if (animationHashes != null && lastPlayedAnimation >= animationHashes.Length)
            lastPlayedAnimation = 0;

        if (anim != null && animationHashes != null && animationHashes.Length > 0)
        {
            anim.PlayIfHas(animationHashes[lastPlayedAnimation]);
        }

        if (ShakeOnDamage && ShakeObj) ShakeObj.ShakeAndBackTo(Vector3.one);
        if (ShowDamageNumber && lastHitDamage > 0)
        {
            DamageNumber.SpawnDamageNumber(lastHitDamage, transform.Above(damageNumberSpot), false);
        }
        OnHit.Invoke();
    }
}
