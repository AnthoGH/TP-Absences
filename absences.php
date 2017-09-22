<?php
try
{
    $bdd = new PDO('mysql:host=localhost;dbname=TPAbsence', 'root', 'adminal');
}
catch(Exception $e)
{
        die('Erreur : '.$e->getMessage());
}

$yesterdayabs = $bdd->query('SELECT idVisiteur, nomVisiteur, dateDebut, nbJours, refmotif
FROM Visiteurs, Absences
WHERE idVisiteur = refVisiteur
AND dateDebut = DATE_SUB(NOW(), INTERVAL 1 DAY);');
 
$neverabs = $bdd->query('SELECT idVisiteur, nomVisiteur
FROM Visiteurs
WHERE idVisiteur NOT IN (SELECT refVisiteur FROM Absences);');

$moreabs = $bdd->query('SELECT refVisiteur, nomVisiteur 
FROM CumulAbsences, Visiteurs
WHERE idVisiteur = refVisiteur
AND NJAV = (SELECT max(NJAV) FROM CumulAbsences);');

$maladeabs = $bdd->query('SELECT refVisiteur, SUM(nbJours) as sumNbJours, nomVisiteur, libelle
FROM Visiteurs, Absences, Motif
WHERE idMotif = refMotif
AND idVisiteur = refVisiteur
AND libelle LIKE "Maladie"
GROUP BY refVisiteur;');

?>

<p>Liste des visiteurs absent hier :</p>

    <?php
    while ($donnees = $yesterdayabs->fetch())
    {
    ?>

    <?php echo $donnees['nomVisiteur']; ?><br>

    <?php
    }
    if(empty($donnees['nomVisiteur'])) {
        echo 'Aucun absent hier !';
    }

    ?>

<p>Liste des visiteurs jamais absent :</p>

    <?php
    while ($donnees = $neverabs->fetch())
    {
    ?>

    <?php echo $donnees['nomVisiteur']; ?><br>

    <?php
    }

    ?>

<p>Le visiteur le plus absent :</p>

    <?php
    while ($donnees = $moreabs->fetch())
    {
    ?>

    <?php echo $donnees['nomVisiteur']; ?><br>

    <?php
    }

    ?>

<p>Liste des visiteurs malade :</p>

    <?php
    while ($donnees = $maladeabs->fetch())
    {
    ?>

    <?php echo $donnees['nomVisiteur'] . ' a été malade ' . $donnees['sumNbJours'] . ' jour(s)'; ?><br>

    <?php
    }

    $reponse->closeCursor();

    ?>
