<?php

namespace App\Repository;

use App\Entity\EmailAccount;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method EmailAccount|null find($id, $lockMode = null, $lockVersion = null)
 * @method EmailAccount|null findOneBy(array $criteria, array $orderBy = null)
 * @method EmailAccount[]    findAll()
 * @method EmailAccount[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EmailAccountRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EmailAccount::class);
    }

    // /**
    //  * @return EmailAccount[] Returns an array of EmailAccount objects
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
    public function findOneBySomeField($value): ?EmailAccount
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
