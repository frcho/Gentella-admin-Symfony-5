<?php

namespace App\Repository;

use App\Entity\EmailSettings;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method EmailSettings|null find($id, $lockMode = null, $lockVersion = null)
 * @method EmailSettings|null findOneBy(array $criteria, array $orderBy = null)
 * @method EmailSettings[]    findAll()
 * @method EmailSettings[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EmailSettingsRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EmailSettings::class);
    }

    // /**
    //  * @return EmailSettings[] Returns an array of EmailSettings objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('e.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?EmailSettings
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
