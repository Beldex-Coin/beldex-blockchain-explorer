//
// Created by mwo on 5/11/15.
//

#ifndef LOKEG01_MICROCORE_H
#define LOKEG01_MICROCORE_H

#include <iostream>

#include "beldex_headers.h"
#include "tools.h"

namespace lokeg
{
    using namespace cryptonote;
    using namespace crypto;
    using namespace std;

    /**
     * Micro version of cryptonode::core class
     * Micro version of constructor,
     * init and destructor are implemted.
     *
     * Just enough to read the blockchain
     * database for use in the example.
     */
    class MicroCore {

        string blockchain_path;

        Blockchain m_blockchain_storage;
        tx_memory_pool m_mempool;
        master_nodes::deregister_vote_pool m_deregister_vote_pool;

        hw::device* m_device;

        network_type nettype;

    public:
        master_nodes::master_node_list m_master_node_list;

        MicroCore();

        bool
        init(const string& _blockchain_path, network_type nt);

        Blockchain&
        get_core();

        tx_memory_pool&
        get_mempool();

        bool
        get_block_by_height(const uint64_t& height, block& blk);

        bool
        get_tx(const crypto::hash& tx_hash, transaction& tx);

        bool
        get_tx(const string& tx_hash, transaction& tx);

        bool
        find_output_in_tx(const transaction& tx,
                          const public_key& output_pubkey,
                          tx_out& out,
                          size_t& output_index);

        uint64_t
        get_blk_timestamp(uint64_t blk_height);

        bool
        get_block_complete_entry(block const& b, block_complete_entry& bce);

        string
        get_blkchain_path();

        hw::device* const
        get_device() const;

        virtual ~MicroCore();
    };



    bool
    init_blockchain(const string& path,
                    MicroCore& mcore,
                    Blockchain*& core_storage,
                    network_type nt);


}



#endif //LOKEG01_MICROCORE_H
